<script>
	globalCSId = <?php echo $_SESSION['CSid'];?>;
</script>

<?php
	function printStatus($status){
		switch($status){
			case "GREEN":
				return '<img src="assets/icon/green.ico" class="statusSymbol">';
			break;
			
			case "RED":
				return '<img src="assets/icon/red.ico" class="statusSymbol">';
			break;
			
			case "!":
				return '<img src="assets/icon/warning.ico" class="statusSymbol">';
			break;
			
			default:
				return "DB Error";
			break;
		}
	}
	
	function printActiveTag($status , $tagId){
		if($status == '1')
			$statusPrint = 'checked';
		else
			$statusPrint = '';
		
		return '<input type="checkbox" name="tagId" class="activeToggler" value="'.$tagId.'" '.$statusPrint.'>';
	}

	$controllerArray = controllersByCSId($_SESSION['CSid']);
	$tagArray = tagsByCSId($_SESSION['CSid']);
?>

<h1>Devices</h1>

<h3 class="headder-devices">Controller</h3><a href="?page=addController"><button type="button" class="btn btn-devices"><span class="glyphicon glyphicon-plus"></span> Add Controller</button></a>
<table id="controller" class="tablesorter">
	<thead>
		<tr>
			<th>Status</th><th>Name</th><th>Location</th><th>Last User, Time</th><th>Details</th>
		</tr>
	</thead>
	<tbody>
			<?php 
			if($controllerArray != null){
				foreach($controllerArray as $controller){
					echo "<tr>
							<td>".printStatus($controller['status'])."</td>
							<td>".$controller['name']."</td>
							<td>".$controller['location']."</td>
							<td>";	
							if(isset($controller['lastUsedByProfile'])){
								echo $controller['lastUsedByProfile'].": ".$controller['lastTimeUsedFrom']." - ";
								if(isset($controller['lastTimeUsedTo']))
									echo $controller['lastTimeUsedTo'];
								else
									echo "In Use";
							}
							else
								echo "Has not been used yet";
							echo'</td>
							<td><a href="?page=detailsController&controller='.$controller['CSerieNo'].'"><button type="button" class="btn btn-default btn-xs">Details</button></a></td>
						</tr>';
				}}
			?>
	</tbody>	
</table>

<h3 class="headder-devices">Tag</h3><a href="?page=addTag"><button type="button" class="btn btn-devices"><span class="glyphicon glyphicon-plus"></span> Add Tag</button></a>
<table id="tag" class="tablesorter">
	<thead>
		<tr>
			<th>Active</th><th>User</th><th>Tag Name</th><th>Last Used, time</th><th>Details</th>
		</tr>
	</thead>
	<tbody>
			<?php 			
			if($tagArray !==null){
				foreach($tagArray as $tag){ //Add a link to profilename with the use of array entry 'PId'
					echo "<tr>
							<td>".printActiveTag($tag['active'],$tag['TSerieNo'])."</td>
							<td>".$tag['profilename']."</td>
							<td>".$tag['tagname']."</td>
							<td>";
							if(isset($tag['lastUsedController'])){
								echo $tag['lastUsedController'].": ".$tag['lastTimeUsedFrom']." - "; 
								if(isset($tag['lastTimeUsedTo']))
									echo $tag['lastTimeUsedTo'];
								else
									echo "In Use";
							}
							else
								echo "Has not been used yet";
							echo'</td>
							<td><a href="?page=detailsTag&tag='.$tag['TSerieNo'].'"><button type="button" class="btn btn-default btn-xs">Details</button></a></td>
						</tr>';
				}}
			?>
		
	</tbody>
</table>
<div id="warningContainer">
</div>

<script>
$(document).ready(function(){ 
        $("#controller").tablesorter(); 
		$("#tag").tablesorter(); 
    } 
); 

$(document).ready(function(){
		$("input.activeToggler").click(function() {
			if($(this).is(':checked')) //See if Active or false
				var isChecked = "1";
			else
				var isChecked = "0";
				
			var tagId = $(this).val();
			
			$.ajax({
				type: "POST",
				url: "ajax/setActiveTag.php",
				data: { CSId: globalCSId, tagId: tagId, active: isChecked },
				success: function(msg) { // msg is the content that the php file 'ECHO's.
					if(msg == 'OK'){
						if(isChecked == '1'){
							showUpdate('#warningContainer','info','Tag is now Active');
						}
						else{
							showUpdate('#warningContainer','info','Tag is no longer Active');
						}
					}
					else{
						showUpdate('#warningContainer','danger','An error has occured, please try again later.');
					}
				
				}
			});
		});
	}
);

function showUpdate(containerName,updateType,msg){
	(function (el) {
		setTimeout(function () {
			$(el.children().first()).remove();
		}, 2500);
	}($(containerName).append(getAlertString(updateType,msg))));
}

function getAlertString(alertType,alertMsg){
	return '<div class="alert alert-'+alertType+' fade in informationDevices"><button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>'+alertMsg+'</div>';
}
</script>
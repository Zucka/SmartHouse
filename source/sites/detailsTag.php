<?php
	if(isset($_POST['cancel'])){
		header('location:?page=devices');
	}
	elseif(isset($_POST['save'])){	//Currently it is only viewing, not saving.
		printDetailTagForm($_GET['tag'],"2","test","");
	}
	elseif(isset($_POST['delete'])){  
		$deletionTag = new Tag($_SESSION['CSid'],$_POST['id']);
		$result = removeObjectFromDB($deletionTag);
		
		if($result == true){
			echo "Tag have been deleted.";
		}
		else{
			echo "An error has occurred, please try again later.";
		}
	}
	else{
		printDetailTagForm($_GET['tag'],"2","test","");
	}

	function printDetailTagForm($id,$user,$name,$errorMsg,$hidden = false){
		echo '
			<h1>Details Tag:'.$id.'</h1>

			<div class="product_container">
				<div class="outer-center">
					<div class="product inner-center">
						'.$errorMsg.'
						<form action="?page=detailsTag" onsubmit="return validate(this);" method="post" class="addForm">
							<table>
								<tr>
									<td>Id:</td> <td><input type="text" name="placeHolder" value="'.$id.'" disabled > <input type="hidden" name="id" value="'.$id.'"> *</td>
								</tr>
								<tr>
									<td>User:</td> 
									<td>
										<select name="user">';
											foreach(profilesByCSId($_SESSION['CSid']) as $profile){
												if($profile['PId'] == $user)
													$selected = "selected";
												else
													$selected = "";

												echo '<option value="'.$profile['PId'].'" '.$selected.'>'.$profile['name'].'</option>';
											}
										echo '</select>*
									</td>
								</tr>
								<tr>
									<td>Name:</td> <td><input type="text" name="name" placeholder="John\'s Keyring" value="'.$name.'"></td>
								</tr>
							</table>
							
							<button class="btn" name="cancel" value="cancel"><span class="glyphicon glyphicon-remove-circle"></span> Cancel</button> <button class="btn" name="save" value="saveTag"><span class="glyphicon glyphicon-floppy-disk"></span> Save</button> <button class="btn" name="delete" value="deleteTag"><span class="glyphicon glyphicon-trash"></span> Delete</button>
						</form>
					</div>
				</div>
				<div class="clear"></div>
			</div>
			';
	}
?>

<script>
	function validate(form){
		clicked = $("button[clicked=true]").val();
		if(clicked == "deleteTag"){
			return confirm('Do you really want to delete this tag?');
		}
		else{
			return true;
		}
	}
	$(document).ready(function() {
		
		$("form button").click(function() {
			$("input button", $(this).parents("form")).removeAttr("clicked");
			$(this).attr("clicked", "true");
		});
	});
</script>
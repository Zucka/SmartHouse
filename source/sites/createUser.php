<?php
	// require_once "../include/headInclude.php";

	if (isset($_GET['action'])) {$action = $_GET['action'];} else {$action = '';}

	if ($action == 'create') {
		if (isset($_POST['name']) && 
			isset($_POST['userName']) && 
			isset($_POST['email']) && 
			isset($_POST['phone']) && 
			isset($_POST['password']) && 
			$_POST['password'] == $_POST['repeatPassword']) {
			// if (createUser($_POST)) {
				// echo (DEVELOPER ? "Accepted" : "" );
				echo '<script type="text/javascript">alert("Ok.");</script>';
			// }
		}
		// else {echo '<script type="text/javascript">alert("Not all are set.");</script>';}
	}
?>

<!DOCTYPE html>
<head>
	<title>Create User</title>
	<!-- JQuery from Google -->
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<!-- JQueryUI from Google -->
<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
<!-- Bootstrap -->
<link href="../assets/css/bootstrap.min.css" rel="stylesheet">
<script src="../assets/js/bootstrap.min.js"></script>

<!-- Our CSS -->
<link href="../assets/css/style.css" rel="stylesheet">

<!-- SITE SPECIFIC CSS -->
<style type="text/css">
	/* all */
::-webkit-input-placeholder { font-style:italic; }
::-moz-placeholder { font-style:italic; } /* firefox 19+ */
:-ms-input-placeholder { font-style:italic; } /* ie */
input:-moz-placeholder { font-style:italic; }
</style>
</head>
<body>
	<div class="container">
		<div class="col-sm-1"></div>
			<div class="col-sm-10">
				<h1>Create a new User</h1>
				</br>
				<form class="form-createUser form-horizontal" role="form" id="createUser" action="?p=createUser&action=create" method="post">
					<div class="form-group">
						<label for="name" class="col-sm-3 control-label">Name: </label>
						<div class="col-sm-8">
							<input type="text" class="form-control" name="name" id="name" placeholder="Name..." required autofocus>
						</div>
					</div>
					<div class="form-group">
						<label for="userName" class="col-sm-3 control-label">Username: </label>
						<div class="col-sm-8">
							<input type="text" class="form-control" name="userName" id="userName" placeholder="Username..." required>
						</div>
					</div>
					<div class="form-group">
						<label for="email" class="col-sm-3 control-label">Email: </label>
						<div class="col-sm-8">
							<input type="email" class="form-control" name="email" id="email" placeholder="john@spc.com" required>
						</div>
					</div>
					<div class="form-group">
						<label for="phone" class="col-sm-3 control-label">Phone: </label>
						<div class="col-sm-8">
							<input type="tel" class="form-control" name="phone" id="phone" placeholder="98766789" required>
						</div>
					</div>
					<div class="form-group">
						<label for="password" class="col-sm-3 control-label">Password: </label>
						<div class="col-sm-8">
							<input type="password" class="form-control" name="password" id="password" placeholder="0-9, a-z, A-Z" required>
						</div>
					</div>
					<div class="form-group">
						<label for="repeatPassword" class="col-sm-3 control-label">Repaet Password: </label>
						<div class="col-sm-8">
							<input type="password" class="form-control" name="repeatPassword" id="repeatPassword" placeholder="0-9, a-z, A-Z" required>
						</div>
					</div>
			        </br>
			        <center>
						<button class="btn btn-lg btn-primary" type="submit">Create User</button>
					</center>
				</form>
			</div>
	</div> <!-- /container -->
</body>
</html>
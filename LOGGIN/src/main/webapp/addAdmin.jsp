<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Admin</title>
</head>
<body>
    <h2>Add Admin</h2>
    <form method="POST" action="addAdminServlet">

        <label for="username">Username: </label>
        <input type="text" id="username" name="username" required><br><br>
        
        <label for="password">Password: </label>
        <input type="password" id="password" name="password" required><br><br>
        
        <input type="submit" value="Add Admin">
    </form>

    <c:if test="${not empty errorMessage}">
        <div style="color: red;">${errorMessage}</div>
    </c:if>
</body>
</html>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add User</title>
</head>
<body>
    <h2>Add User</h2>
    <form method="POST" action="addUserServlet">

        <label for="username">Username: </label>
        <input type="text" id="username" name="username" required><br><br>
        
        <label for="password">Password: </label>
        <input type="password" id="password" name="password" required><br><br>
        
        <input type="submit" value="Add User">
    </form>

    <c:if test="${not empty errorMessage}">
        <div style="color: red;">${errorMessage}</div>
    </c:if>
</body>
</html>

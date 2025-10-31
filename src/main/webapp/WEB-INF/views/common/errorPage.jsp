<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>에러 발생</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f8f8f8; text-align: center; padding-top: 50px; }
        .container { background-color: #fff; padding: 30px; border: 1px solid #ccc; display: inline-block; }
        h1 { color: #d9534f; }
        p { margin: 15px 0; }
        a { text-decoration: none; color: #337ab7; }
        a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <div class="container">
        <h1>⚠️ 오류 발생</h1>
        <p>${error != null ? error : "알 수 없는 오류가 발생했습니다."}</p>
        
        <p><a href="/approval24">홈 페이지로 이동</a></p>
    </div>
</body>
</html>

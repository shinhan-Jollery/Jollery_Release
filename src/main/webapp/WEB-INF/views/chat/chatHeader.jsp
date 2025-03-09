<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<style>
.chat-messages {
	overflow: hidden;
	overflow-y: auto;
	max-height: calc(100vh - 200px);
}

.message-content {
	display: block;
	text-align: left;
}

.chat-header .d-flex {
	display: flex;
	justify-content: center;
	width: 100%;
	margin: 0;
}

.chat-photo {
	width: 40px;
	height: 40px;
	object-fit: cover;
}

.text-center {
	text-align: center;
}

.text-end {
	text-align: right;
}

h5.text-truncate {
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.blockButton {
	padding: 8px 16px;
	background-color: #ff4d4d;
	color: white;
	border: none;
	border-radius: 5px;
	font-size: 14px;
	cursor: pointer;
	transition: background-color 0.3s;
}

.blockButton:hover {
	background-color: #e60000;
}

.message-divider {
	display: flex;
	justify-content: center;
	align-items: center;
	margin: 20px 0;
}

.message-divider small {
	background-color: #f1f1f1;
	color: #444444 !important;
	border-radius: 20px;
	padding: 5px 15px;
	font-size: 12px;
	border-radius: 20px;
}
</style>
<!-- bootstrap -->
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=no, maximum-scale=1, shrink-to-fit=no, viewport-fit=cover">

<link class="css-lt" rel="stylesheet"
	href="${path}/resources/chat/assets/css/template.bundle.css"
	media="(prefers-color-scheme: light)">

<script src="${path}/resources/chat/assets/js/chatVendor.js"></script>
<script src="${path}/resources/chat/assets/js/chatTemplate.js"></script>

<!--  webSocket -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.2/sockjs.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

<!-- dropzone -->
<link
	href="https://cdn.jsdelivr.net/npm/dropzone@5.7.0/dist/min/dropzone.min.css"
	rel="stylesheet">
<script src="${path}/resources/chat/assets/js/dropzone.js"></script>

<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

</head>
</html>
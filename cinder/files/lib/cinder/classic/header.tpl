#!/usr/bin/haserl
Content-type: text/html

<%

. /lib/cinder/common.sh

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
  <head>
    <title>Cinder - <%= $CINDER_page %></title>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8"></meta>
    <link rel="stylesheet" href="/css/cinder.css" type="text/css"></link>
    <script src="/js/cinder.js" type="text/javascript"></script>
  </head>
  <body>
    <div id="header">
      <h1>wing-project.org [[<%= $CINDER_nodeid %>]]</h1> 
      <div id="tabs">
        <ul id="globalnav">
        <% 
          cinder_print_menu
	%>
        </ul>
      </div>
    </div>
    <div id="body">
      <div id="content">
      <% 
        if [ "$CINDER_nb_pages" -gt 1 ]; then
          cinder_print_submenu
      %>
        <h2><%= $CINDER_page %></h2>
      <%
        fi
      %>

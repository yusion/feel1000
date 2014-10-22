<!DOCTYPE HTML>
<html>  
<head>
	{{!web_head}}
</head>
<body>
{{!page_head}}	
<a href="profile">test</a>

<HR>
<BR>
<BR>
<div id="qunit"></div>
  <div id="qunit-fixture"></div>
  <script src="//code.jquery.com/qunit/qunit-1.15.0.js"></script>
  <script type="text/javascript">
  QUnit.module( "group a" );
QUnit.test( "a basic test example", function( assert ) {
  assert.ok( true, "this test is fine" );
});
QUnit.test( "a basic test example 2", function( assert ) {
  assert.ok( true, "this test is fine" );
});
 
QUnit.module( "group b" );
QUnit.test( "a basic test example 3", function( assert ) {
  assert.ok( true, "this test is fine" );
});
QUnit.test( "a basic test example 4", function( assert ) {
  assert.ok( true, "this test is fine" );
});
  </script>
{{!page_foot}}	
</body>
</html>


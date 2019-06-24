<div class="tag-cloud">
<div class="tag-cloud-tags" id="tags">
{{ tagcloud({min_font: 12, max_font: 30, amount: 200, color: true, start_color: '#fff', end_color: '#fff'}) }}
</div>
</div>
<br>

<script type="text/javascript">
var alltags=document.getElementById('tags');
var tags=alltags.getElementsByTagName('a');

for (var i = tags.length - 
1; i >= 0; i--) {
    var r=Math.floor(Math.random()*75+130);
    var g=Math.floor(Math.random()*75+100);
    var b=Math.floor(Math.random()*75+80);
    tags[i].style.background = "rgb("+r+","+g+","+b+")";
}
</script>

<style type="text/css">
div#posts.posts-expand .tag-cloud a{
background-color: #f5f7f1;
border-radius: 6px;
padding-left: 10px;
padding-right: 10px;
margin-top: 18px;

}

.tag-cloud a{
background-color: #f5f7f1;
border-radius: 4px;
padding-right: 5px;
padding-left: 5px;
margin-right: 5px;
margin-left: 0px;
margin-top: 8px;
margin-bottom: 0px;
}

.tag-cloud-tags{
text-align: left;
counter-reset: tags;
}
</style>
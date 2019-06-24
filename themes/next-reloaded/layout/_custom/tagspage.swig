<div class="tag-cloud">
<div class="tag-cloud-tags" id="tags">
{{ tagcloud({min_font: 12, max_font: 30, amount: 200, color: true, start_color: '#fff', end_color: '#fff'}) }}
</div>
</div>
<br>

<script type="text/javascript">
var alltags=document.getElementById('tags');
var tags=alltags.getElementsByTagName('a');

//随机颜色
function getColor() {
    var colorElements = "0,1,2,3,4,5,6,7,8,9,a,b,c,d,e,f";
    var colorArray = colorElements.split(",");
    var color = "#";
    for (var i = 0; i < 6; i++) {
        color += colorArray[Math.floor(Math.random() * 16)];
    }
    return color;
}

//随机字体
function getSize(){
    return Math.floor(Math.random() * (30 - 10) + 10);
}

//改变样式
function getTagHtml(tagArr){
    if(tagArr!=null && tagArr.length>0){
        for(var i=0;i<tagArr.length;i++){
            var color = getColor();
            var size = getSize();
            tagArr[i].style.background = color;
            tagArr[i].style.fontSize=size+'px';
        }
    }
}

getTagHtml(tags);
</script>

<style type="text/css">
div#posts.posts-expand .tag-cloud a{
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
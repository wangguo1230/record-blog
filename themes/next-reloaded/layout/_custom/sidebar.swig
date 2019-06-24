<!--标签云-->
{% if site.tags.length > 1 %}
<script type="text/javascript" charset="utf-8" src="{{ url_for('/js/tagcloud.js') }}"></script>
<script type="text/javascript" charset="utf-8" src="{{ url_for('/js/tagcanvas.js') }}"></script>
<div class="widget-wrap">
    <h3 class="widget-title">Tag Cloud</h3>
    <div id="myCanvasContainer" class="widget tagcloud">
        <canvas width="200" height="250" id="resCanvas" style="width:100%">
            {{ list_tags() }}
        </canvas>
    </div>
</div>
<style>
.widget-title{
    border-left: 4px solid #16a085;
    padding-left: 5px;
    background: #f7f7f7;
}
</style>
{% endif %}
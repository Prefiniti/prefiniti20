<div id="SystemClock" style="color:white; background-color:black; -moz-opacity:0.70; -moz-border-radius:5px; position:absolute; right:8px; top:8px; font-size:large; font-family:Verdana, Arial, Helvetica, sans-serif; text-align:center; padding:5px; width:120px; z-index:2000;">&nbsp;
    
</div>

<div id="SystemGPS" style="color:white; background-color:black; -moz-opacity:0.70; -moz-border-radius:5px; position:absolute; right:8px; bottom:8px; font-size:large; font-family:Verdana, Arial, Helvetica, sans-serif; text-align:center; padding:5px; width:220px; z-index:2000;">&nbsp;
    
</div>

<div id="ItemBasket" style="color:white; background-color:black; -moz-opacity:0.70; -moz-border-radius:5px; position:absolute; left:8px; bottom:20px; font-size:large; font-family:Verdana, Arial, Helvetica, sans-serif; text-align:left; padding:5px; width:220px; height:auto; z-index:2000; display:none;">
    <p style="font-size:small; font-weight:bold; margin-top:0px; padding-top:0px;"><img src="/graphics/basket.png" align="absmiddle"/> Item Basket</p>
    
    <div id="ItemBasketItems" style="font-size:x-small; font-weight:normal;">
    
    </div>
    <div id="ItemBasketCount" style="font-size:xx-small; font-weight:bold; font-family:Verdana, Arial, Helvetica, sans-serif; color:gold; margin-top:8px; margin-bottom:3px;">
    
    </div>
    <div style="width:100%; border:1px solid #EFEFEF;">
    	<p style="font-size:x-small; font-weight:bold; margin-top:0px; padding-top:0px;">Basket Options</p>
    	<label style="font-size:xx-small; color:white;"><input type="checkbox" id="DeleteOnLetGo" name="DeleteOnLetGo" checked /> Remove items when I let them go</label>
	</div>        
</div>

<div class="PNotifyBox" id="PNotifyBoxWrapper">
	
        
        
        <div id="PNotifyBox" style="float:left; width:100%; text-align:center;">

        </div>
        
        <div style="display:none;">
        	<cfinclude template="/framework/components/quick_status/qs_gps.cfm">
        </div><br /><br />
    <div id="ChatDebugArea"></div>
    <div id="uploadWrapper" style="display:none; width:100%;">
        
        <div id="ulProgress">
            
        </div>
        <div style="display:none;">
        <center>
        
        <input type="button" class="normalButton" id="test" name="test" onclick="glob_uploader.startUpload();" value="Start Upload">
        <input type="button" class="normalButton" id="cancelFUpload" value="Cancel Uploads" onclick="cancelQueue(glob_uploader);">
        </center>
        </div>
    </div>
    
    

	<div id="Chat_NotifyBox">
    
    </div>
</div>
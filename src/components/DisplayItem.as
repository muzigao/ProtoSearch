// ActionScript file
package components {
	import components.ResultItem;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	import mx.controls.Alert;
	import org.osmf.events.TimeEvent;

	public class DisplayItem extends Sprite {

		public function DisplayItem(result:ResultItem, tthHelper:TerrificTabHelper) { //picture url for people, event and so on
			//category of each item	
			displayItem.buttonMode = true;

			//add background
			this.drawBackgroundSquare(result.type);

			//add picture
			load.contentLoaderInfo.addEventListener(Event.COMPLETE, drawPicture);
			load.load(new URLRequest(result.imageURL));

			//add name
			if (result.type == ResultType.PERSON) {
				this.nameStr = result.name.split(" ")[0];
			} else {
				this.nameStr = result.name;
			}
			this.addName();

			//add tooltip
			this.tooltipInfo = result.name;
			this.drawTooltip();

			//todo: click to open in new tab
			this.url = result.url;
			_tthHelper = tthHelper;

		}

		private var _tthHelper:TerrificTabHelper;
		private var bgHeight:Number = 80;

		private var bgWidth:Number = 60; //width and height of background square

		private var cover:Sprite = new Sprite();

		private var displayItem:Sprite = new Sprite();
		private var load:Loader = new Loader();
		private var mutFriendList:MutualList;

		private var nameStr:String;
		private var nameTF:TextField;

		private var picSize:Number = 50; //width and height of picture
		private var profileImg:Bitmap;

		private var timer:Timer = new Timer(500, 1);
		private var tooltip:Tooltip;
		private var tooltipInfo:String;
		private var url:String;

		protected function addName():void {

			this.nameTF = new TextField();
			this.nameTF.text = this.nameStr;

			this.nameTF.width = this.nameTF.textWidth + 5;
			var ratio:Number = 1;

			if (nameTF.textWidth >= bgWidth) {
				ratio = bgWidth / nameTF.width;

				nameTF.scaleX = ratio;
				nameTF.scaleY = ratio;

			}
			this.nameTF.x = -nameTF.textWidth * ratio / 2;
			this.nameTF.y = bgWidth / 2 - nameTF.textHeight * ratio / 2;
			this.addChild(nameTF);
		}

		protected function drawBackgroundSquare(resultType:ResultType):void {
			displayItem.graphics.beginFill(0xffffff);
			displayItem.graphics.drawRoundRect(x - bgWidth / 2, y - bgHeight / 2,
				bgWidth, bgHeight, 10, 10);
			displayItem.graphics.endFill();

			var color:Number = this.getColorByType(resultType);
			displayItem.graphics.lineStyle(4, color);
			displayItem.graphics.drawRoundRect(x - bgWidth / 2, y - bgHeight / 2,
				bgWidth, bgHeight, 10, 10);

			this.addChild(displayItem);
		}

		protected function drawCover():void {
			cover.graphics.beginFill(0x666666, 0);
			cover.graphics.drawRoundRect(x - bgWidth / 2, y - bgHeight / 2, bgWidth,
				bgHeight, 10, 10);
			cover.graphics.endFill();
			cover.buttonMode = true;

			cover.addEventListener(MouseEvent.CLICK, openLink);
			displayItem.addChild(cover);
		}

		protected function drawPicture(event:Event):void {
			profileImg = Bitmap(load.content);

			if (profileImg.width >= profileImg.height) {
				profileImg.height = picSize * profileImg.height / profileImg.width;
				profileImg.width = picSize;
			} else {
				profileImg.width = picSize * profileImg.width / profileImg.height;
				profileImg.height = picSize;
			}

			profileImg.x = -profileImg.width / 2;
			profileImg.y = -profileImg.height / 2 - 10;

			displayItem.addChild(profileImg);
			displayItem.addEventListener(MouseEvent.CLICK, openLink);
		}

		protected function drawTooltip():void {
			displayItem.addEventListener(MouseEvent.MOUSE_OVER, startTooltip);
			displayItem.addEventListener(MouseEvent.MOUSE_OUT, hideTooltip)
		}

		protected function getColorByType(resultType:ResultType):Number {
			var color:Number;
			switch (resultType) {
				case ResultType.PERSON:
					color = 0x5B9AB6; //PERSON
					break;
				case ResultType.EVENT:
					color = 0xCADAE1; //GROUP
					break;
				case ResultType.GROUP:
					color = 0xEAC4C4; //EVENT
					break;
				case ResultType.PAGE:
					color = 0xC44747; //PAGE
					break;

			}
			return color;
		}

		protected function hideTooltip(event:MouseEvent):void {
			if (timer.currentCount == 1) {
				displayItem.removeChild(tooltip);
			}
			timer.reset();
		}

		//todo:
		protected function openLink(event:MouseEvent):void {
			_tthHelper.addTab(nameStr, url);
		}

		protected function showTooltip(event:TimerEvent):void {
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, showTooltip);

			tooltip = new Tooltip(this.tooltipInfo);
			tooltip.x = mouseX + 8;
			tooltip.y = mouseY + 5;

			displayItem.addChild(tooltip);
		}

		protected function startTooltip(event:MouseEvent):void {
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, showTooltip);
			timer.start();
		}
	}
}

package components {
	import components.ResultItem;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.BitmapFilter;
	import flash.filters.DropShadowFilter;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.utils.Timer;

	public class ConnectionItem extends Sprite {


		public function ConnectionItem(result:ResultItem, tthHelper:TerrificTabHelper) {
			//add container
			this.drawContainer();

			color = this.getColorByType(result.type);
			nameStr = result.name;

			//add picture
			load.contentLoaderInfo.addEventListener(Event.COMPLETE, drawPicture);
			load.load(new URLRequest(result.imageURL));

			//add name
			this.drawName();
			this.buttonMode = true;

			//add tooltip
			this.tooltipInfo = result.name;
			this.drawTooltip();

			//todo: add click function
			this.url = result.url;
			_tthHelper = tthHelper;
			this.nameStr = result.name;
			this.addEventListener(MouseEvent.CLICK, openLink);

		}

		private var _tthHelper:TerrificTabHelper;
		private var bgHeight:Number = 70;
		private var bgWidth:Number = 50;
		private var color:Number;
		private var connectionItem:Sprite = new Sprite();

		private var load:Loader = new Loader();
		private var nameStr:String;

		private var nameTF:TextField;
		private var picSize:Number = 40;
		private var profileImg:Bitmap;
		private var timer:Timer = new Timer(500, 1);

		private var tooltip:Tooltip;
		private var tooltipInfo:String;

		private var url:String;

		protected function drawContainer():void {
			//draw container
			connectionItem.graphics.beginFill(0xffffff, 1);
			connectionItem.graphics.drawRoundRect(x - bgWidth / 2, y - bgHeight /
				2, bgWidth, bgHeight, 5, 5);
			connectionItem.graphics.endFill();

			//draw filter
			var bgFilter:BitmapFilter;
			bgFilter = new DropShadowFilter(2, 90, color, 1.0, 3, 3, 1, 15);
			connectionItem.filters = [bgFilter];

			this.addChild(connectionItem);
		}

		protected function drawName():void {
			this.nameTF = new TextField();
			this.nameTF.text = this.nameStr;
			this.nameTF.width = this.nameTF.textWidth + 5;
			var ratio:Number = 1;

			if (nameTF.textWidth >= bgWidth) {
				ratio = bgWidth / nameTF.width;

				nameTF.scaleX = ratio;
				nameTF.scaleY = ratio;

			}

			this.nameTF.x = -nameTF.textWidth * ratio / 2 + 5;
			this.nameTF.y = bgWidth / 2 - nameTF.textHeight * ratio / 2;

			this.addChild(nameTF);

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
			profileImg.y = -profileImg.height / 2 - (bgHeight - bgWidth) / 2;

			this.addChild(profileImg);
		}

		protected function drawTooltip():void {
			connectionItem.addEventListener(MouseEvent.MOUSE_OVER, startTooltip);
			connectionItem.addEventListener(MouseEvent.MOUSE_OUT, hideTooltip)
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
				connectionItem.removeChild(tooltip);
			}
			timer.reset();
		}

		//to do:
		protected function openLink(event:MouseEvent):void {
			_tthHelper.addTab(nameStr, url);
		}

		protected function showTooltip(event:TimerEvent):void {
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, showTooltip);

			tooltip = new Tooltip(this.tooltipInfo);
			tooltip.x = mouseX + 8;
			tooltip.y = mouseY + 5;

			connectionItem.addChild(tooltip);
		}

		protected function startTooltip(event:MouseEvent):void {
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, showTooltip);
			timer.start();
		}
	}
}

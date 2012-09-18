// ActionScript file
package components {
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.ui.Mouse;
	import flash.utils.Timer;

	public class MutFriendItem extends Sprite {

		//picURL: profile img of mutual friend
		//tooltipStr: text content displayed for each mutual friend
		public function MutFriendItem(picURL:String, tooltipStr:String) {
			this.buttonMode = true;
			this.drawBackground();

			load.contentLoaderInfo.addEventListener(Event.COMPLETE, loadPicture);
			load.load(new URLRequest(picURL));

			//draw tooltip
			this.tooltipInfo = tooltipStr;
			this.drawTooltip();

			//todo: add click function
			this.addEventListener(MouseEvent.CLICK, openLink);
		}

		private var background:Sprite = new Sprite();
		private var bgSize:Number = 50;
		private var load:Loader = new Loader();

		private var picSize:Number = 40;
		private var profileImg:Bitmap;

		private var timer:Timer = new Timer(500, 1);
		private var tooltip:Tooltip;
		private var tooltipInfo:String;

		protected function changePicSize(bitPic:Bitmap):Bitmap {
			if (bitPic.width >= bitPic.height) {
				bitPic.height = picSize * bitPic.height / bitPic.width;
				bitPic.width = picSize;
			} else {
				bitPic.width = picSize * bitPic.width / bitPic.height;
				bitPic.height = picSize;
			}
			return bitPic;
		}

		protected function drawBackground():void {
			background.graphics.beginFill(0xffffff, 1);
			background.graphics.drawRect(0, 0, bgSize, bgSize);
			background.graphics.endFill();
			this.addChild(background);
		}

		protected function drawTooltip():void {
			this.addEventListener(MouseEvent.MOUSE_OVER, startTooltip);
			this.addEventListener(MouseEvent.MOUSE_OUT, hideTooltip)
		}

		protected function hideTooltip(event:MouseEvent):void {
			if (timer.currentCount == 1) {
				this.removeChild(tooltip);
			}
			timer.reset();
		}

		protected function loadPicture(event:Event):void {
			profileImg = Bitmap(load.content);
			profileImg = this.changePicSize(profileImg);
			profileImg.x = bgSize / 2 - profileImg.width / 2;
			profileImg.y = bgSize / 2 - profileImg.height / 2;
			background.addChild(profileImg);
		}

		//to do:
		protected function openLink(event:MouseEvent):void {

		}

		protected function showTooltip(event:TimerEvent):void {
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, showTooltip);

			tooltip = new Tooltip(this.tooltipInfo);
			tooltip.x = 10;
			tooltip.y = 60;
			this.addChild(tooltip);
		}

		protected function startTooltip(event:MouseEvent):void {
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, showTooltip);
			timer.start();
		}
	}
}

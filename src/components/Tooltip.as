// ActionScript file
package components {
	import flash.display.Sprite;
	import flash.filters.BitmapFilter;
	import flash.filters.DropShadowFilter;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	public class Tooltip extends Sprite {

		public function Tooltip(textStr:String) {
			textfield = new TextField();
			textfield.text = textStr;
			textfield.width = textfield.textWidth + 5;
			textfield.x = 10;
			textfield.y = 6;

			//create tooltip

			tooltip = new Sprite();
			tooltip.graphics.beginFill(0xffffff, 0.8);
			tooltip.graphics.drawRoundRect(0, 0, textfield.width + 20, 30, 5, 5);

			tooltip.graphics.moveTo(10, 0);
			tooltip.graphics.lineTo(16, -4.5);
			tooltip.graphics.lineTo(22, 0);

			tooltip.graphics.endFill();

			//draw tooltip filter
			tooltipFilter = new DropShadowFilter(1, 90, 0xBAB2B1, 0.8, 2, 2, 1, 15);
			tooltip.filters = [tooltipFilter];

			tooltip.addChild(textfield);
			this.addChild(tooltip);

		}

		private var textfield:TextField = new TextField();
		private var textformat:TextFormat = new TextFormat();

		private var tooltip:Sprite = new Sprite();
		private var tooltipFilter:BitmapFilter;
	}
}

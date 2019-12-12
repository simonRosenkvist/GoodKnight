package scene {
	
	import asset.powerupGFX;
	
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	
	public class Powerglow extends DisplayStateLayerSprite {
		private var skin:powerupGFX
		
		public function Powerglow() {
			
			super();
		}
		
		override public function init():void {
			this.skin = new powerupGFX;
			this.skin.scaleX = 0.2;
			this.skin.scaleY = 0.2;
			this.addChild(skin);
		}//End init
		
		override public function dispose():void {
			this.removeChild(skin);
			this.skin = null;
		}//End dispose
	}
}
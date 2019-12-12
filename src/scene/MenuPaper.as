package scene {
	
	import flash.display.MovieClip;
	import asset.menuboardGFX;
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	
	public class MenuPaper extends DisplayStateLayerSprite {
		public var skin:MovieClip;
		
		public function MenuPaper() {
			
			super();
		}
		override public function init():void {
			initSkin();	
		}//End init
		
		private function initSkin():void {
			this.skin = new menuboardGFX;
			this.addChild(skin);
		}//End initSkin
		
		override public function dispose():void {
			this.removeChild(skin);
			this.skin = null;
		}//End dispose
	}
}
package scene {
	
	import flash.display.MovieClip;
	import asset.menubackgroundGFX;
	
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	
	public class MenuBackground extends DisplayStateLayerSprite {
		private var skin:MovieClip;
		
		public function MenuBackground() {
			
			super();
			
		}//End Constructor
	
	override public function init():void {
			this.skin = new menubackgroundGFX;
			this.addChild(skin);
		}//End init
	override public function dispose():void {
		this.removeChild(skin);
		this.skin = null;
	}//End dispose
	}//End Class
}//End package
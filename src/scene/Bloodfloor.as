package scene {
	
	import flash.display.MovieClip;
	
	import asset.bloodfloormonkGFX;
	
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	import se.lnu.stickossdk.system.Session;
	
	public class Bloodfloor extends DisplayStateLayerSprite {
		private var skin:MovieClip;
		
		public function Bloodfloor() {
			
			super();
		}
		
		override public function init():void {
		this.skin = new bloodfloormonkGFX;	
		this.skin.gotoAndStop(Math.round(Math.random()*2));
		this.addChild(skin);
		Session.timer.create(10000, remove);
		}//End init
		
		override public function dispose():void {
			
		}//End dispose	
		
		private function remove():void {
			this.removeChild(skin);
			this.skin = null;
		}//End remove
	}
}
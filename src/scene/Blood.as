package scene {
	
	import flash.display.MovieClip;
	import asset.bloodwallGFX;
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	import se.lnu.stickossdk.system.Session;
	
	public class Blood extends DisplayStateLayerSprite {
		public var skin:MovieClip;
		
		public function Blood() {
			super();
		}
		override public function init():void {
			initSkin();
		}//End init
		
		private function initSkin():void {
		this.skin = new bloodwallGFX();
		this.skin.gotoAndStop(Math.round(Math.random()*2));
		this.addChild(skin);
		Session.timer.create(10000, remove);
		}//End initSkin
		
		override public function dispose():void {
		//	this.removeChild(skin);
		//	this.skin = null;
		}//End dispose
		
		private function remove():void {
			this.removeChild(this.skin);
			this.skin = null;
		}//End remove
	}
}
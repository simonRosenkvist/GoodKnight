package player
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import asset.platform1GFX;
	
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	
	public class Platform extends DisplayStateLayerSprite {
		
		private var m_Platform:MovieClip;
		public var box:Sprite;
		
		public function Platform()
		{
			super();
		}
		override public function init():void{
			this.m_initPlatformL();
		}//End init
		
		public function m_initPlatformL():void {
			this.m_Platform = new platform1GFX();
			this.addChild(this.m_Platform);
		}//End m_initPlatform
		
		override public function dispose():void {
			this.removeChild(m_Platform);
			//this.removeChild(box);
			this.m_Platform = null;
			this.box = null;
			
		}
	}
}
import flash.display.Sprite;

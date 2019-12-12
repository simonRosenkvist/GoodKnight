package player
{
	import flash.display.MovieClip;
	
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	
	public class PlatformRight extends DisplayStateLayerSprite {
		
		private var m_Platform:MovieClip;
		
		public function PlatformRight()
		{
			super();
		}
		override public function init():void{
			this.m_initPlatformR();
		}//End init
		
		public function m_initPlatformR():void {
			this.m_Platform = new platform1_rightGFX();
			this.addChild(this.m_Platform);
		}//End m_initPlatform
	}
}
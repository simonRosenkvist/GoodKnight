package scene {
	
	import flash.display.MovieClip;
	
	import asset.howtoplaymenuGFX;
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;
	
	public class HowToPlay extends DisplayState {
		private var m_skin:MovieClip;//menu skin
		private var m_layer:DisplayStateLayer;//info layer
		private var m_controls:EvertronControls;//control input
		public var nr:int;//nr of players
		private var choiseSound:SoundObject;
		private var m_music:SoundObject;
		
		public function HowToPlay(nr) {
			this.nr = nr;
			super();
		}//End constructor
		
		override public function init():void {
			initControls();
			initLayer();
			initSkin();
			initSound();
		}//End init
		
		private function initSound():void {
			
			Session.sound.musicChannel.sources.add("menuMusic", GoodKnight.MENU_MUSIC);
			this.m_music = Session.sound.musicChannel.get("menuMusic");
			this.m_music.volume = 0.5;
			this.m_music.play();
			
			Session.sound.soundChannel.sources.add('choiseSound', GoodKnight.MENU_CHOOSING_SOUND);
			this.choiseSound = Session.sound.soundChannel.get("choiseSound");
			this.choiseSound.volume = 0.5;
			this.choiseSound.play();
		}//End initSound
		
		private function initControls():void {
			this.m_controls = new EvertronControls(0);
		}//End initControls
		
		private function initLayer():void {
			this.m_layer = this.layers.add("htp");
		}//End init Layer
		
		private function initSkin():void {
			this.m_skin = new howtoplaymenuGFX;
			this.m_skin.x = 400;
			this.m_skin.y = 300;
			this.m_layer.addChild(m_skin);
		}//End initSkin
		
		override public function update():void {
			checkControls();
		}//End update
		
		private function checkControls():void {
			if(Input.keyboard.justPressed(m_controls.PLAYER_BUTTON_1)) {
				Session.application.displayState = new Game(nr);}
		}//End checkControls
	}
}
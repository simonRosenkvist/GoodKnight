package scene {
	
	import flash.display.Sprite;
	import asset.creditsmenuGFX;
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;
	
	public class Credits extends DisplayState {
		private var m_skin:Sprite;
		private var m_controls:EvertronControls;
		private var m_layer:DisplayStateLayer;
		private var choiseSound:SoundObject;
		private var m_music:SoundObject;
		
		public function Credits() {
			super();
			
		}//End constructor
		
		override public function init():void {
			initControls();
			initLayer();
			initSkin();
			initSound();
		}//End init
		
		private function initLayer():void {
		this.m_layer = layers.add('CreditsLayer');	
		}//End initLayer
		
		private function initSkin():void {
			this.m_skin = new creditsmenuGFX;
			this.m_skin.x = 400;
			this.m_skin.y = 300;
			this.m_layer.addChild(m_skin);
		}//End initSkin
		
		private function initControls():void {
			m_controls = new EvertronControls(0); //0 = player 1 controls, 1 = player 2 controls//
		}//End init
		
		private function initSound():void {
			
			Session.sound.musicChannel.sources.add("menuMusic", GoodKnight.MENU_MUSIC);
			this.m_music = Session.sound.musicChannel.get("menuMusic");
			this.m_music.volume = 0.7;
			this.m_music.play();
			
				Session.sound.soundChannel.sources.add('choiseSound', GoodKnight.MENU_CHOOSING_SOUND);
				this.choiseSound = Session.sound.soundChannel.get("choiseSound");
				this.choiseSound.volume = 0.5;
				this.choiseSound.play();
			}//End initSound
		
		override public function update():void {
			if(Input.keyboard.justPressed(m_controls.PLAYER_BUTTON_1)) {
				Session.application.displayState = new Menu();}
		}//End init
	}
}
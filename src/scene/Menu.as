package scene {
	
	import flash.display.MovieClip;
	import asset.menubackgroundGFX;
	import asset.menuboardGFX;
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;
	
	public class Menu extends DisplayState {
		
		private var m_controls:EvertronControls; //input controls
		private var scroll:MovieClip; //skin paper (menu)
		private var skin:MovieClip; //skin background (bricks)
		private var m_layer:DisplayStateLayer;//back layer
		private var n_layer:DisplayStateLayer;//front layer
		public var count:int = 1; //choise on menu nr
		private var m_music:SoundObject; //Background music
		private var selectSound:SoundObject;//Switching menu sound
		private var choiseSound:SoundObject;//Pick option menu sound
		
		public function Menu() {
			super();
			this.m_controls = new EvertronControls(0); // 0 = player 1, 1 = player 2.
		}
		
		override public function init():void {
			initLayer();
			initSkin();
			initMusic();
		}//End init
		
		private function initLayer():void {
			this.m_layer = this.layers.add("menu");
			this.n_layer = this.layers.add("scrollLayer");
		}//End initLayer
		
		private function initMusic():void {
			Session.sound.soundChannel.sources.add('choiseSound', GoodKnight.MENU_CHOOSING_SOUND);
			this.choiseSound = Session.sound.soundChannel.get("choiseSound");
			this.choiseSound.volume = 0.5;
			this.choiseSound.play();
			
			Session.sound.musicChannel.sources.add("menuMusic", GoodKnight.MENU_MUSIC);
			this.m_music = Session.sound.musicChannel.get("menuMusic");
			this.m_music.volume = 1;
			this.m_music.play();
		}
		
		private function initSkin():void {
			this.skin = new menubackgroundGFX;
				this.skin.x = 400;
				this.skin.y = 300;
				this.m_layer.addChild(skin);
				
			this.scroll = new menuboardGFX;
				this.scroll.x = 400;
				this.scroll.y = 350;
				this.n_layer.addChild(scroll);
				this.scroll.gotoAndStop('menu1');
		}//End initSkin
		
		override public function update():void {
			this.m_updateControls();
				changeMenu();
		}//End update
		
		override public function dispose():void {
			
		}//End dispose
		
		private function m_updateControls():void {
			
			if(Input.keyboard.justPressed(this.m_controls.PLAYER_BUTTON_1)) {
				Session.sound.soundChannel.sources.add('choiseSound', GoodKnight.MENU_CHOOSING_SOUND);
					this.choiseSound = Session.sound.soundChannel.get("choiseSound");
					this.choiseSound.volume = 0.5;
					this.choiseSound.play();
					
						if (count == 1 || count == 2) {
							Session.application.displayState = new HowToPlay(this.count);
				}//Starts game
				
				if (count == 3) {Session.application.displayState = new Highscore();}
				if (count == 4) {Session.application.displayState = new Credits();}
				
			}//End if
		}//End update
		
		private function changeMenu():void {
			if (Input.keyboard.justPressed(this.m_controls.PLAYER_DOWN)) {
				Session.sound.soundChannel.sources.add('selectSound', GoodKnight.MENU_CHOICE_SOUND);
					this.selectSound = Session.sound.soundChannel.get("selectSound");
					this.selectSound.volume = 0.5;
					this.selectSound.play();
				
						this.count ++;
							if (count == 5) {
								this.count = 1;
				}//END IF
					this.scroll.gotoAndStop('menu'+count);
			}
			if(Input.keyboard.justPressed(this.m_controls.PLAYER_UP)) {
				Session.sound.soundChannel.sources.add('selectSound', GoodKnight.MENU_CHOICE_SOUND);
					this.selectSound = Session.sound.soundChannel.get("selectSound");
					this.selectSound.volume = 0.5;
					this.selectSound.play();
					
						this. count --;
							if (this.count == 0) {
								this.count = 4;
				}//End if count
					this.scroll.gotoAndStop('menu'+count);
			}//END IF
		}//End changeMenu
	}
}
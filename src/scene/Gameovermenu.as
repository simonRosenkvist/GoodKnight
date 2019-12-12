package scene {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	import asset.gameovermenuGFX;
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;
	
	public class Gameovermenu extends DisplayState {
		private var m_skin:MovieClip;
		private var m_layer:DisplayStateLayer;
		private var m_controls:EvertronControls = new EvertronControls(0); // 0 = player 1, 1 = player 2
		private var count:int = 2;
		private var nr:int;
		private var m_music:SoundObject;
		private var selectSound:SoundObject;
		private var score:int;
		private var lockKeyboard:Boolean = false;
		private var scoreTxt:String;
		private var scoreField:TextField = new TextField();
		
		public function Gameovermenu(nr, score) {
			this.score = score;
			this.nr = nr;
			super();
		}
		override public function init():void {
			initLayer();
			initMusic();
			initSkin();
			
			Session.highscore.smartSend(nr, score, 10, unlock);
			if (Session.highscore.smartSend) {lockKeyboard = true;}
		}//End init
		
		private function initLayer():void {
			this.m_layer = this.layers.add('gameOverMenu');
		}//End initLayer
		
		private function initSkin():void {
			this.m_skin = new gameovermenuGFX;
			this.m_skin.x = 400;
			this.m_skin.y = 300;
			this.m_skin.gotoAndStop('gameover_'+count);
			this.m_layer.addChild(m_skin);
				
				this.scoreField.x = 200;
				this.scoreField.y = 0;
				this.scoreTxt = 'Score: ' + this.score.toString();
				this.scoreField.text = scoreTxt;
				this.scoreField.scaleX = 8;
				this.scoreField.scaleY = 8;
				this.scoreField.textColor = 0x990000;
				this.m_layer.addChild(scoreField);
				
		}//End initSkin
		
		private function initMusic():void {
			Session.sound.musicChannel.sources.add("gameOverMusic", GoodKnight.GAMEOVER_MUSIC);
			this.m_music = Session.sound.musicChannel.get("gameOverMusic");
			this.m_music.volume = 0.2;
			this.m_music.play();
		}//End initMusic
		
		override public function update():void {
			keyHandler();
		}//End update
		
		private function keyHandler():void {
			if (Input.keyboard.justPressed(this.m_controls.PLAYER_UP) && lockKeyboard == false) {
				Session.sound.soundChannel.sources.add('selectSound', GoodKnight.MENU_CHOICE_SOUND);
					this.selectSound = Session.sound.soundChannel.get("selectSound");
					this.selectSound.volume = 0.5;
					this.selectSound.play();
						
						count ++;
					 if(count == 4) {count = 2}
						
							this.m_skin.gotoAndStop('gameover_'+count);
			}//End up
			if (Input.keyboard.justPressed(this.m_controls.PLAYER_DOWN) && lockKeyboard == false) {
				Session.sound.soundChannel.sources.add('selectSound', GoodKnight.MENU_CHOICE_SOUND);
					this.selectSound = Session.sound.soundChannel.get("selectSound");
					this.selectSound.volume = 0.5;
					this.selectSound.play();
				
						count --;
					if (count == 1){count = 3}
				
							this.m_skin.gotoAndStop('gameover_'+count);
			}//End down
			if (Input.keyboard.justPressed(this.m_controls.PLAYER_BUTTON_1) && lockKeyboard == false) {
				if (count == 2) {Session.application.displayState = new Game(nr);}
				if (count == 3) {Session.application.displayState = new Menu();}
			}//End press
		}//End keyHandler
		
		private function unlock(a):void {
			lockKeyboard = false;
		}//End checkKeylock
	}
}
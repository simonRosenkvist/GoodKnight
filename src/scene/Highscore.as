package scene {
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import asset.highscoreGFX;
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;
	
	public class Highscore extends DisplayState {
		private var m_controls:EvertronControls;
		private var m_skin:Sprite;
		private var m_layer:DisplayStateLayer;
		private var choiseSound:SoundObject;//enter sound
		private var m_music:SoundObject;
		private var p1Score:TextField//High score single player
		private var p1Name:TextField//High score single player
		private var p2Score:TextField//High score multiplayer
		private var p2Name:TextField//High score multiplayer
		private var i:int//loop variable
		private var scoreArr:Vector.<String> = new Vector.<String>;
		private var scoreArr2:Vector.<String> = new Vector.<String>;
		
		public function Highscore() {
			super();
		}//End constructor
		
		override public function init():void {
			init_controls();
			initSound();
			initLayer();
			initSkin();
		}//End init
		
		private function initLayer():void {
			this.m_layer =  this.layers.add('highScoreLayer');
		}//End initLayer
		
		private function initSkin():void {
			
			this.m_skin = new highscoreGFX;
			this.m_skin.x = 400;
			this.m_skin.y = 300;
			this.m_layer.addChild(m_skin);
			
		 	Session.highscore.receive(1, 10, displayP1Score);
			Session.highscore.receive(2, 10, dispalyP2Score);
		
		}//End initSkin
		
		private function displayP1Score(playerOnePackage):void {
			
			var xml:XML = playerOnePackage;
			
				for (i=0; i < xml.items.item.length(); i++) {

					p1Name = new TextField();
					p1Name.text += i+1 +'. ' + xml.items.item[i].name + ': ';
					p1Name.scaleX = 1.8;
					p1Name.scaleY = 1.8;
					p1Name.x = 80;
					p1Name.y = 150 + i*30;
					this.m_layer.addChild(p1Name);
						
						p1Score = new TextField();
						p1Score.text += xml.items.item[i].score;
						p1Score.scaleX = 1.8;
						p1Score.scaleY = 1.8;
						p1Score.x = 260;
						p1Score.y = 150 + i*30;
						this.m_layer.addChild(p1Score);
					//trace(xml.items.item[i].name + ' ' + xml.items.item[i].score);
					
					
				}//End loop
						
				
			}//End displayP1Score
		
		private function dispalyP2Score(playerTwoPackage):void {
			var xml:XML = playerTwoPackage;
			
				for (i=0; i < xml.items.item.length(); i++) {
					p2Name = new TextField();
					p2Name.text += i+1 +'. ' + xml.items.item[i].name + ': ';
					p2Name.scaleX = 1.8;
					p2Name.scaleY = 1.8;
					p2Name.x = 490;
					p2Name.y = 150 + i*30;
					this.m_layer.addChild(p2Name);	
					
					p2Score = new TextField();
					p2Score.text += xml.items.item[i].score;
					p2Score.scaleX = 1.8;
					p2Score.scaleY = 1.8;
					p2Score.x = 670;
					p2Score.y = 150 + i*30;
					this.m_layer.addChild(p2Score);
				}//End loop
				
			}//End displayP2Score
		
		private function init_controls():void {
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
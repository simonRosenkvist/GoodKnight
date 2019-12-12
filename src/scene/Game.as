package scene {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	import asset.gameoverGFX;
	import player.Batmonster;
	import player.Platform;
	import player.Spelare;
	import player.Spelare2;
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	import se.lnu.stickossdk.fx.Flicker;
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;
	
	public class Game extends DisplayState {
		private var batMonster:Batmonster;
		public var m_player:Spelare; //player 1
		public var n_player:Spelare2; //player 2 
		private var m_layer:DisplayStateLayer; //game layer
		private var n_layer:DisplayStateLayer; //monster layer
		private var p_layer:DisplayStateLayer; //player layer
		private var f_layer:DisplayStateLayer; //frontview layer (such as pillars)
		private var g_layer:DisplayStateLayer; //platform layer
		public var h_layer:DisplayStateLayer; //HUD layer
		public var m_platform:Platform; //platform class
		public var platList:Vector.<DisplayStateLayerSprite> = new Vector.<DisplayStateLayerSprite>; //array for platforms
		private var i:int; //loop variable
		public var monsterHandler:MonsterHandler; //monsterhandler class
		private var sceneHandler:SceneHandler; //bakcground objects, not platforms!
		private var HeadsUpDisplay:HUD; //HUD class
		private var wounded:Boolean; //makes p1 inv
		private var wounded2:Boolean; //makes p2 inv
		private var flickMe:Flicker; //flick effect
		private var batWave:int = 4; //increasing nr with bats each wave
		private var cultWave:int = 6; //increasing nr with cultist each wave
		public var nr:int; //Number of players (sent from Menu)...
		private var m_music:SoundObject;//Background music
		public var score:int = 0;//score for player(s)
		private var go:MovieClip;//game over screen
		private var end:Boolean = false;
		private var powerGlow:Powerglow;//Power dont work
		private var scoreTxt:TextField = new TextField();//Score keeper
		private var scoreString:String;//score to string
		
		public function Game(nr) {
			super();
			this.nr = nr; //is 1 or 2 for amount of players
		}//End Game
		
		override public function init():void {
			this.m_initLayers(); //creates layers
			this.m_initPlatforms(); // creates platforms and floor
			this.m_initPlayer(); //creates one or two players
			this.m_initMonsters(); //creates waves of monsters from mosnster handler
			this.m_initScene(); //creates background elements
			this.m_initHUD(); //creates HUD
			this.m_initMusic();//starts music for game gameState
		}//End init
		
		private function m_initMusic():void {
			Session.sound.musicChannel.sources.add("gameMusic", GoodKnight.GAME_MUSIC);
			this.m_music = Session.sound.musicChannel.get("gameMusic");
			this.m_music.volume = 1;
			this.m_music.play();
		}//End m_initMusic
		
		private function m_initHUD():void { //Creates HUD
			this.HeadsUpDisplay = new HUD(nr, m_player, n_player);
			this.HeadsUpDisplay.x = 400;
			this.HeadsUpDisplay.y = 24;
			h_layer.addChild(HeadsUpDisplay);
		}//End initHUD
		
		private function m_initScene():void {
		this.sceneHandler = new SceneHandler(m_layer, n_layer, f_layer); //SceneHandler creates back- & foreground objects
		this.sceneHandler.initScene();
		}//End initScene
		
		
		private function m_initLayers():void {
			this.m_layer = this.layers.add("game"); //game layer
			this.n_layer = this.layers.add("view"); //monster layer
			this.p_layer = this.layers.add("playerLayer"); //player layer
			this.f_layer = this.layers.add("frontView"); //foreground
			this.g_layer = this.layers.add("platformLayer"); //platform layer
			this.h_layer = this.layers.add("HUD"); //HUD layer
		}//End m_initLayers
		
		private function m_initPlayer():void { //creates player one
			this.m_player = new Spelare(platList);
			this.m_player.x = 100;
			this.m_player.y = 550;
			this.p_layer.addChild(this.m_player);
			
			this.powerGlow = new Powerglow;
			this.powerGlow.x = 400;
			this.powerGlow.y = 300;
			this.m_player.addChild(powerGlow);
			
			if(this.nr == 2) { //p2 check	
				this.n_player = new Spelare2(platList); //creates player two
				this.n_player. x = 200;
				this.n_player.y = 550;
				this.p_layer.addChild(this.n_player);
			}
		}//End m_initPlayer
		
		private function m_initPlatforms():void { //creates platforms
			this.m_platform = new Platform();
			platList.push(this.m_platform);
			
			this.m_platform = new Platform();
			this.m_platform.x = -420;
			this.m_platform.y = 400;
			g_layer.addChild(this.m_platform);
			platList.push(this.m_platform);
			//End platform 1 left
			
			this.m_platform = new Platform();
			this.m_platform.x = -500;
			this.m_platform.y = 200;
			g_layer.addChild(this.m_platform);
			platList.push(this.m_platform);
			//End platform 2 left
			
			this.m_platform = new Platform();
			this.m_platform.x = 500;
			this.m_platform.y = 400;
			g_layer.addChild(this.m_platform);
			platList.push(this.m_platform);
			//End platform 1 left
			
			this.m_platform = new Platform();
			this.m_platform.x = 550;
			this.m_platform.y = 200;
			g_layer.addChild(this.m_platform);
			platList.push(this.m_platform);
			//End platform 2 right
			
			this.m_platform = new Platform(); //floor
			this.m_platform.x = - 10;
			this.m_platform.y = 590;
			this.m_platform.scaleX = 1.2;
			
			g_layer.addChild(this.m_platform);
			platList.push(this.m_platform);
			
		}//End initPlatforms
		
		override public function update():void { //update fires 60 times every sec
			checkHit(); //check hitboxes
			waveHandler();
			updateScore();
			this.monsterHandler.batMonsterCoordinator(); //launches group-logic for batmonsters
			this.monsterHandler.cultMonsterCoordinator(); //launches group-logic fo cultmonsters
		}//End update
		
		private function m_initMonsters():void { //skall göras om så att den körs via update?
			this.monsterHandler = new MonsterHandler(n_layer, m_player, n_player, nr);
				for (i=0; i<batWave+1*this.nr; i++) {
					this.monsterHandler.addBat();
				}
				for (i=0; i<cultWave+1*this.nr; i++) {
					this.monsterHandler.addCultist();
				}
				
		}//End initMonsters
		
		private function checkHit():void { // PLAYER ONE HIT CHECK
			
			if (this.m_player.HP1 < 1 && end == false && nr == 1) {
				end = true;
				this.m_player.m_skin.gotoAndStop('knight1_death');
				this.go = new gameoverGFX;
				this.go.x = 400;
				this.go.y = 300;
				go.gotoAndStop('1');
				this.g_layer.addChild(go);
				Session.timer.create(2800, endGame);
			}//One player game over
			
			for (i=0; i<monsterHandler.batMonsterList.length; i++) { //Batmonster hitcheck
				if (this.m_player.hitBox.hitTestObject(monsterHandler.batMonsterList[i].eHitBox) && wounded == false &&
					this.m_player.inv == false) {
					this.m_player.HP1 -=1;
					wounded = true;
					
					flickMe = new Flicker(this.m_player, 1500, 60, true);
					Session.effects.add(flickMe);
					Session.timer.create(1500, removeInvulnerability);
					
				}//End if
				
				if (monsterHandler.batMonsterList[i].spit) {
				if (monsterHandler.batMonsterList[i].spit.hitTestObject(this.m_player.hitBox) && wounded == false && 
					this.m_player.inv == false) {
					this.m_player.HP1 -=1;
					wounded = true;
					
					flickMe = new Flicker(this.m_player, 1500, 60, true);
					Session.effects.add(flickMe);
					Session.timer.create(1500, removeInvulnerability);
				}//Hit test if
			}//End spit if
				
		}//End loop
			
			for (i=0; i<monsterHandler.cultMonsterList.length; i++) { //cultist hitcheck collision
				if (this.m_player.hitBox.hitTestObject(monsterHandler.cultMonsterList[i].eHitbox) && wounded == false && 
					this.m_player.inv == false) {
					this.m_player.HP1 -=1;
					wounded = true;
					
					flickMe = new Flicker(this.m_player, 1500, 60, true);
					Session.effects.add(flickMe);
					Session.timer.create(1500, removeInvulnerability);
				}//End if
				
				//cultist hitcheck tentacle
				if(monsterHandler.cultMonsterList[i].atkBox) {//checks tentacle hitbox
				if(this.m_player.hitBox.hitTestObject(monsterHandler.cultMonsterList[i].atkBox) && wounded == false && 
					this.m_player.inv == false) {
					this.m_player.HP1 -=1;
					wounded = true;
					
					flickMe = new Flicker(this.m_player, 1500, 60, true);
					Session.effects.add(flickMe);
					Session.timer.create(1500, removeInvulnerability);
					}//End if
				}
			}//End loop
			
			
			if (nr == 2) { // PLAYER TWO HIT CHECK
				
				if (this.m_player.HP1 < 1 && this.n_player.HP2 < 1 && end == false && nr == 2) {
					end = true;
					this.m_player.m_skin.gotoAndStop('knight1_death');
					this.n_player.m_skin.gotoAndStop('knight2_death');
					this.go = new gameoverGFX;
					this.go.x = 400;
					this.go.y = 300;
					go.gotoAndStop('1');
					this.g_layer.addChild(go);
					Session.timer.create(2800, endGame);
				}//Two players game over
				
				if (this.m_player.HP1 < 1) {
					this.m_player.m_skin.gotoAndStop('knight1_death');
				}
				
				if (this.n_player.HP2 < 1) {
					this.n_player.m_skin.gotoAndStop('knight2_death');
				}
			for (i=0; i<monsterHandler.batMonsterList.length; i++) { //Batmonster hitcheck
				if (this.n_player.hitBox.hitTestObject(monsterHandler.batMonsterList[i].eHitBox) && wounded2 == false && 
					this.n_player.inv == false) {
					this.n_player.HP2 -=1;
				
						wounded2 = true;
							flickMe = new Flicker(this.n_player, 1500, 60, true);
								Session.effects.add(flickMe);
								Session.timer.create(1500, removeInvulnerability);
				}//End if
				
				if (monsterHandler.batMonsterList[i].spit) {
					if (monsterHandler.batMonsterList[i].spit.hitTestObject(this.n_player.hitBox) && wounded == false && 
						this.n_player.inv == false) {
						this.n_player.HP2 -=1;
						wounded = true;
						
						flickMe = new Flicker(this.n_player, 1500, 60, true);
						Session.effects.add(flickMe);
						Session.timer.create(1500, removeInvulnerability);
					}//End if hit check
				}//End if spit
				
			}//end loop
			
			for (i=0; i<monsterHandler.cultMonsterList.length; i++) { //cultist hitcheck
				if (this.n_player.hitBox.hitTestObject(monsterHandler.cultMonsterList[i].eHitbox) && wounded2 == false && 
					this.n_player.inv == false) {
					this.n_player.HP2 -=1;
					wounded2 = true;
					
					flickMe = new Flicker(this.n_player, 1500, 60, true);
					Session.effects.add(flickMe);
					Session.timer.create(1500, removeInvulnerability2);
				}//End if
				
				if(monsterHandler.cultMonsterList[i].atkBox) {//checks tentacle hitbox
					if(this.n_player.hitBox.hitTestObject(monsterHandler.cultMonsterList[i].atkBox) && wounded == false && 
						this.n_player.inv == false) {
						this.n_player.HP2 -=1;
						wounded = true;
						
						flickMe = new Flicker(this.n_player, 1500, 60, true);
						Session.effects.add(flickMe);
						Session.timer.create(1500, removeInvulnerability);
					}//End if
				}
			}//End loop
		}//End p2check
	}//End checkHit
		
		private function updateScore():void {
			if (nr==1) {
				score = this.m_player.score;
			}//End player one check
			
			if (nr==2) {
				score = this.m_player.score + this.n_player.score;
			}//End player two check
				
				this.scoreString = score.toString();
				this.scoreTxt.text = scoreString;
				this.scoreTxt.x = 380;
				this.scoreTxt.y = 10;
				this.scoreTxt.scaleX = 2;
				this.scoreTxt.scaleY = 2;
				this.h_layer.addChild(this.scoreTxt);
			
		}//End updateScore
		
		private function removeInvulnerability():void {
			wounded = false;
		}//End removeInvulnerability
		
		private function removeInvulnerability2():void {
			wounded2 = false;
		}//End removeInvulnerability
		
		public function waveHandler():void {
			if (monsterHandler.batMonsterList.length < 1 && monsterHandler.cultMonsterList.length <1) {
				cultWave +=1;
				batWave +=1;
				m_initMonsters();
			}//End if
		}//End handling waves
		
		private function endGame():void {
			if (nr==1){score = this.m_player.score;
				Session.application.displayState = new Gameovermenu(nr, score);
			}//One player score
			
			if (nr==2){score = this.m_player.score + this.n_player.score;
				Session.application.displayState = new Gameovermenu(nr, score);
			}//Two players score
		}
	}
}
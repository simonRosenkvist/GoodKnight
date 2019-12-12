package {	
	import scene.Menu;
	import se.lnu.stickossdk.system.Engine;
	[SWF(width="800", height="600", frameRate="60", backgroundColor="#000000")]
	
	public class GoodKnight extends Engine {
		
		[Embed(source = "../asset/audio/backgroundmusicmainmenu.mp3")]
		public static const MENU_MUSIC:Class;
		
		[Embed(source = "../asset/audio/backgroundmusicgame.mp3")]
		public static const GAME_MUSIC:Class;
		
		[Embed(source = "../asset/audio/gameovermusic.mp3")]
		public static const GAMEOVER_MUSIC:Class;
		
		[Embed(source = "../asset/audio/batmonsterdeath.mp3")]
		public static const BATMONSTER_DEATH_SOUND:Class;
		
		[Embed(source = "../asset/audio/knightdeath.mp3")]
		public static const KNIGHT_DEATH_SOUND:Class;
		
		[Embed(source = "../asset/audio/knightswing.mp3")]
		public static const KNIGHT_SWING_SOUND:Class;
		
		[Embed(source = "../asset/audio/menuchoice.mp3")]
		public static const MENU_CHOICE_SOUND:Class;
		
		[Embed(source = "../asset/audio/menuchoosing.mp3")]
		public static const MENU_CHOOSING_SOUND:Class;
		
		[Embed(source = "../asset/audio/monkmonsterdeath.mp3")]
		public static const MONKMONSTER_DEATH_SOUND:Class;
		
		[Embed(source = "../asset/audio/monkmonsterslime.mp3")]
		public static const MONKMONSTER_SLIME_SOUND:Class;
		
		[Embed(source = "../asset/audio/monkmonsterhit.mp3")]
		public static const MONKMONSTER_HIT:Class;
		
		[Embed(source = "../asset/audio/batmonsterhit.mp3")]
		public static const BATMONSTER_HIT:Class;
		
		[Embed(source = "../asset/audio/powerup.mp3")]
		public static const RAGE:Class;
		
		public function GoodKnight() {
			
		}
		
		override public function setup():void {
			this.initId = 38;
			this.initDebugger = true;
			this.initDisplayState = Menu;
		}
	}
}
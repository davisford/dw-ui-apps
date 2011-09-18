package modules.shared
{
	public class Icons
	{
		public function Icons()	{}
		
		[Embed(source="../../assets/images/cold-hot-arrow.png")]
		[Bindable]
		public static var COLD_HOT:Class;
		
		[Embed(source="../../assets/images/wet-dry-arrow.png")]
		[Bindable]
		public static var WET_DRY:Class;
		
		[Embed(source="../../assets/images/dark-light-arrow.png")]
		[Bindable]
		public static var DARK_LIGHT:Class;
		
		[Embed(source="../../assets/images/outlet.jpg")]
		[Bindable]
		public static var OUTLET:Class;
		
		
	}
}
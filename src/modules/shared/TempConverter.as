package modules.shared
{
	import mx.collections.ArrayCollection;

	/**
	 * This class works with the temp sensor built into the hygro petal.  It can be used
	 * to convert the raw value to either C or F
	 */
	public class TempConverter
	{
		// static lookup table
		// each array: { H:raw hygro val, C:celsius, F:fahrenheit }
		private static const TEMP:ArrayCollection = new ArrayCollection([
			[18.34500029, 150, 302],
			[20.59933369, 145, 293],
			[23.18569376, 140, 284],
			[26.15715622, 135, 275],
			[29.57428358, 130, 266],
			[33.51389440, 125, 257],
			[38.07711860, 120, 248],
			[43.35891445, 115, 239],
			[49.48382707, 110, 230],
			[56.60193469, 105, 221],
			[64.89261330, 100, 212],
			[74.54830336, 95, 203],
			[85.79201862, 90, 194],
			[98.88075881, 85, 185],
			[114.1513859, 80, 176],
			[131.9626339, 75, 167],
			[152.5839360, 70, 158],
			[176.4260179, 65, 149],
			[203.9447558, 60, 140],
			[235.4105012, 55, 131],
			[271.0705623, 50, 122],
			[311.1992764, 45, 113],
			[355.6810176, 40, 104],
			[404.3123677, 35, 95],
			[456.5234509, 30, 86],
			[511.5000000, 25, 77],
			[568.0907150, 20, 68],
			[624.9145459, 15, 59],
			[680.5388324, 10, 50],
			[733.5181245, 5, 41],
			[782.5995676, 0, 32],
			[826.8614184, -5, 23],
			[865.7266860, -10, 14],
			[899.0000000, -15, 5],
			[926.8154159, -20, -4],
			[949.5545241, -25, -13],
			[967.7624190, -30, -22],
			[982.0636255, -35, -31],
			[993.0959399, -40, -40]
		]);
				
		public static function toCelsius(val:Number):Number {
			// short circuit; if outside the bounds give the boundary value
			if(val <= TEMP.source[0][0]) { return TEMP.source[0][1]; }
			
			// arr[0] is the point below, arr[1] is the point above
			var arr:Array = findLoHi(val, TEMP.source);
			return interpolate(val, arr[0][0], arr[0][1], arr[1][0], arr[1][1]);
		}
		
		public static function toFahrenheit(val:Number):Number {
			// short circuit; if outside the bounds give the boundary value
			if(val >= TEMP.source[TEMP.length-1][0]) { return TEMP.source[TEMP.length-1][1]; }
			
			// arr[0] is the point below, arr[1] is the point above
 			var arr:Array = findLoHi(val, TEMP.source);
			return interpolate(val, arr[0][0], arr[0][2], arr[1][0], arr[1][2]);
		}
		
		/**
		 * We do a simple linear interpolation here with the two closest data points
		 * http://en.wikipedia.org/wiki/Interpolation
		 */
		private static function interpolate(x:Number, x1:Number, y1:Number, x2:Number, y2:Number):Number {
			/* y = y1 + (y2 - y1) ( (x - x1) / (x2 - x1) ) */
			var val:Number = y1 + (y2 - y1) * ( (x - x1) / (x2 - x1) );
			return val;
		}
		
		/**
		 * Variation on Quicksort to find the two data points that our val sits between
		 */
		private static function findLoHi(val:Number, arr:Array):Array {
			if(arr.length == 2) {
				// terminating case
				return arr;
			}
			// find pivot/middle
			var middle:int = arr.length/2;
			
			// don't go outside max array bounds
			var next:int = ( (middle+1) == (arr.length-1) ) ? arr.length-1 : middle+1;
			
			// where does our value lie?
			var order:int = order(val, arr[middle], arr[next]);
			
			switch(order) {
				case -1:
					// recursion
					return findLoHi(val, arr.slice(0, next));
				case 0:
					// terminating case
					return new Array(arr[middle], arr[next]);
				case 1:
					// recursion
					return findLoHi(val, arr.slice(next, arr.length));
				default:
					throw new Error("Numbers don't add up");
			}
		}
		
		/**
		 * Returns -1 if val is less than lo and hi
		 * Returns 0  if val is between lo and hi
		 * Returns 1  if val is greater than lo and hi
		 */
		private static function order(val:Number, lo:Array, hi:Array):int {
			var loVal:Number = lo[0];
			var hiVal:Number = hi[0];
			if(loVal < val && val < hiVal) { return 0; }
			else if(loVal < val && hiVal < val) { return 1; }
			else { return -1; }
		}
		
		public static function CtoF(val:Number):Number {
			return Number((((val * 9) / 5 ) + 32).toFixed(3));
		}
		
		public static function FtoC(val:Number):Number {
			return Number((((val - 32) * 5 ) / 9).toFixed(3));
		}
	}
}
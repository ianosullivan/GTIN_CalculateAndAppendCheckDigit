<cfcomponent hint="Hold all utilty functions">

	<!---
		Useful links;
		-> http://en.wikipedia.org/wiki/International_Article_Number_(EAN)
		-> http://www.gs1.org/how-calculate-check-digit-manually
	--->
	<cffunction name="CalculateAndAppendCheckDigit" returnType="string" hint="This takes in a value and returns it with the check digit appended">
		<cfargument name="initial_val" type="string">

		<cfset var weight = 1>
		<cfset var sum = 0>

		<!--- If odd or even length start with 3 or 1 and flip/flop this value for calculations --->
		<cfif BitAnd( len(initial_val), 1 )>
			<cfset weight = 3>
		</cfif>

		<cfloop from="1" to="#len(initial_val)#" index="i">
			<!--- Get the current value --->
			<cfset var digit = mid(initial_val, i, 1)>

			<cfset sum += digit * weight>

			<!--- Swap the weight --->
			<cfset weight = (weight EQ 3 ? 1 : 3) />
		</cfloop>

		<cfset var check_digit = ceiling(sum / 10) * 10 - sum>

		<cfreturn initial_val & check_digit>
	</cffunction>


</cfcomponent>

//Picks a random element from a list based on a weighting system:
//1. Adds up the total of weights for each element
//2. Generates a random value between 0% to 100% of previous total value.
//3. For each element in the list, subtracts its weighting from that number
//4. If that makes the number 0 or less, return that element.
/proc/pickweight(list/L, base_weight = 1)
	var/total = 0
	var/item
	for (item in L)
		if (!L[item])
			L[item] = base_weight
		total += L[item]

	total = rand() * total
	for (item in L)
		total -= L[item]
		if (total <= 0)
			return item

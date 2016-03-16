#Read TestData into dictionary of T
def ReadTestData(testPath):
	global T
	result_file = open(testPath,'r').readlines()
	for result in result_file:
		u=int(result.split('\t')[0])
		items = (result.split('\t')[1].strip()).split(',')
		while '' in items:
			items.remove('')
		T[u] = items

def score(S, T):
	result_file = open(S,'r').readlines()
	score = 0.0
	for result in result_file:
		u=int(result.split('\t')[0])
		r = (result.split('\t')[1].strip()).split(',')#predict ordered itemlist
		while '' in r:
			r.remove('')
		if u in T and len(r)>0:
			t = T[u] #Test itemList
			score+=20 * (precisionAtK(r, t, 2) + precisionAtK(r, t, 4) + recall(r, t) + userSuccess(r, t)) + 10 * (precisionAtK(r, t, 6) + precisionAtK(r, t, 20))
	print ("prediction result:")
	print (score)
	return score


#precision within the first top k items: 
def precisionAtK(recommendedItems, relevantItem, k):
	topK = recommendedItems[0:k] #takes first k items from the list of reccommendedItems
	return len(list(set(topK)&set(relevantItem)))/k


#recall = fraction of relevant, retrieved items (30 items 
#are allowed to be submitted at maximum per user): 
def recall(recommendedItems, relevantItem):
	if (len(relevantItem)> 0):
		return	len(list(set(recommendedItems[0:30])&set(relevantItem)))/len(relevantItem)
	else: 
		return 0.0
#user success = was at least one relevant item recommended for a given user?
def userSuccess(recommendedItems, relevantItem):
	if len(list(set(recommendedItems[0:30])&set(relevantItem))):
		return 1.0
	else:
		return 0.0
		
def main():
	ReadTestData(testPath) 
	score(predictPath,T)
	
if __name__ == '__main__':
	T={}; #u-itemlist
	testPath = "D:\\lyl\\junshen\\code\\testResult.txt"
	predictPath = "D:\\lyl\\junshen\\code\\predictResult.txt"
	main()
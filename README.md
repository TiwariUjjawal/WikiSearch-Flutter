# WikiSearch-Flutter

A Flutter mobile application which provides:
  *  Wikipedia Search.
  *  Random Wikipedia Articles.
  *  Top News in India.

App has following features.
  * Once user search a query, All the Search results related to query are cached.
  * User can download summary of the wikipedia page visited.
  * Summary can be deleted also.
  * Recent visited page history is maintained.
  * User can delete the visited history.

Following API's are used.
  * Fetching Wikipedia articles
      * https://en.wikipedia.org/w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description&gpslimit=10&gpssearch=albert&gpsoffset=0
      
  * Fetching wikipedia article page using pageId
      * https://en.wikipedia.org/w/api.php?action=query&prop=info&inprop=url&format=json&pageids=717
      
  * Fetching summary of Wikipedia article 
      * https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro&explaintext&redirects=1&pageids=717
     
  * Fetching random articles using pageId
      * https://en.wikipedia.org/w/api.php?action=query&list=random&format=json&rnnamespace=0&rnlimit=10
      
  * Fetching Top Live News in India
      * https://newsapi.org/v2/top-headlines?country=in&apiKey=f4bc54e7e76b48f19915f5424b1156cc

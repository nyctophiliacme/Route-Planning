/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
var loaderDiv = $("#loader");
var innerLoaderDiv = $("#innerLoaderPart");
var outerLoaderDiv = $("#outerLoaderPart");
var LoaderFunctions = {
    showLoader : function() {
        loaderDiv.css('display', 'block');
        outerLoaderDiv.css('display','block');
        innerLoaderDiv.css('display','block');
    },
    
    hideLoader : function() {
        loaderDiv.css('display', 'none');
        outerLoaderDiv.css('display','none');
        innerLoaderDiv.css('display','none');
    }
}

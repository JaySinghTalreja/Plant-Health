const router = require('express').Router();
var multer  = require('multer')

router.get('', function(request, response) {
    response.json({
        STATUS:"WORKING",
        MSG:"API STARTED"
    });
});
router.get('predict', function(request, response){
    response.json({
        "error" : "0",
        "message" : "PLANT DISEASE DETECTION API By Jay Singh Talreja"
    });
});
router.post('predict', async function(request, response) {
    if(request.body) {
        var requestData = 
    }
});
module.exports = router;
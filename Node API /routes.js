const router = require('express').Router();
var multer  = require('multer')


var storage = multer.diskStorage({
    destination: function (req, file, cb) {
      cb(null, '/Uploads')
    },
    filename: function (req, file, cb) {
      const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9)
      cb(null, file.fieldname + '-' + uniqueSuffix)
    }
  })
  
  var upload = multer({ storage: storage })



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
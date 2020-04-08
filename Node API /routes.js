const router = require('express').Router();
var multer  = require('multer')


var storage = multer.diskStorage({
    destination: function (req, file, cb) {
      cb(null, 'Uploads/')
    },
    filename: function (req, file, cb) {
      const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9)
      cb(null, file.fieldname + '-' + uniqueSuffix)
    }
  });

var upload = multer({ storage: storage }).single('testImage')

router.post('/predict', function (req, res) {
  upload(req, res, function (err) {
    if (err instanceof multer.MulterError) {
      // A Multer error occurred when uploading.
    } else if (err) {
      // An unknown error occurred when uploading.
    }

    // Everything went fine.
  })
});

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
module.exports = router;
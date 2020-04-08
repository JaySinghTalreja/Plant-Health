const router = require('express').Router();
router.get('', function(request, response) {
    response.json({
        STATUS:"WORKING",
        MSG:"API STARTED"
    });
});
router.post('predict', async function(request, response) {
    
});
module.exports = router;
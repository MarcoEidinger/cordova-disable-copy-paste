/* jshint jasmine: true */
exports.defineAutoTests = function() {

    describe('Plugin', function() {
        it("should exist", function() {
            expect(window.cordova.plugins.disableCopyPaste).toBeDefined();
        });

        it("should offer a start function", function() {
            expect(window.cordova.plugins.disableCopyPaste.start).toBeDefined();
            expect(typeof window.cordova.plugins.disableCopyPaste.start == 'function').toBe(true);
        });

        it("should offer a stop function", function() {
            expect(window.cordova.plugins.disableCopyPaste.stop).toBeDefined();
            expect(typeof window.cordova.plugins.disableCopyPaste.stop == 'function').toBe(true);
        });
    });

    describe('Basic integration test', function() {
        it("shal handle multple starts and stops", function(done) {
            window.cordova.plugins.disableCopyPaste.start(function() {
                window.cordova.plugins.disableCopyPaste.start(done.fail, function(sError) {
                    window.cordova.plugins.disableCopyPaste.stop(function() {
                        window.cordova.plugins.disableCopyPaste.stop(done.fail, function() {
                            expect("Yuuh").toBeDefined();
                            done();
                        });
                    }, done.fail);
                });
            }, done.fail);
        });
    });
};

exports.defineManualTests = function(contentEl, createActionButton) {

    createActionButton('Test', function() {
        window.cordova.plugins.disableCopyPaste.start(function(bStatus) {
            console.log('Success');
        }, function(sError) {
            console.log('ERROR: ' + sError);
        });
    });

};

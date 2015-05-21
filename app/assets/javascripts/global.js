$(document).ready(function () {

    if ($('#uploadBtn').length) {
        document.getElementById("uploadBtn").onchange = function () {
            document.getElementById("uploadFile").value = this.value.substring(12);
        };
    };

    var checkPayplanOption = function() {
        if($('#payplan-radio-1').is(':checked')) {
            $('#payplan-option-2').removeClass('bg-success');
            $('#payplan-option-3').removeClass('bg-success');
            $('#payplan-option-1').addClass('bg-success');

        }   else {
                $('#payplan-option-1').removeClass('bg-success');
                $('#payplan-option-3').removeClass('bg-success');
                $('#payplan-option-2').addClass('bg-success');
            }

        // if ('#payplan-radio-2:checked') {
        //     $('#payplan-option-1').removeClass('bg-success');
        //     $('#payplan-option-2').addClass('bg-success');
        // };
    };

    
    var togglePayplanOption = function() {
        $('#payplan-radio-1').click(function() {
            $('#payplan-option-2').removeClass('bg-success');
            $('#payplan-option-3').removeClass('bg-success');
            $('#payplan-option-1').addClass('bg-success');
        });

        $('#payplan-radio-2').click(function() {
            $('#payplan-option-1').removeClass('bg-success');
            $('#payplan-option-3').removeClass('bg-success');
            $('#payplan-option-2').addClass('bg-success');
        });
        $('#payplan-radio-3').click(function() {
            $('#payplan-option-1').removeClass('bg-success');
            $('#payplan-option-2').removeClass('bg-success');
            $('#payplan-option-3').addClass('bg-success');
        });
    };

    checkPayplanOption();
    togglePayplanOption();
});

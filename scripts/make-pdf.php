#!/usr/bin/php
<?php
require_once 'vendor/autoload.php';
use Dompdf\Dompdf;

// instantiate and use the dompdf class
$dompdf = new Dompdf();
$dompdf->loadHtml(file_get_contents($argv[1]));

// (Optional) Setup the paper size and orientation
$dompdf->setPaper('A4', 'portrait');

// Render the HTML as PDF
$dompdf->render();

// Output the generated PDF to File
if (file_put_contents($argv[2], $dompdf->output()) > 0) {

    return 0;
}

return 1;

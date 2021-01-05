# postProBolidos
Desktop app for astrometric and photometric calibration of meteor videos.
Video filenames must follow the pattern of videos generated with acquisition app github.com/jmcaldas/bolidosGUI, namely "Station_Id_yyyy-mm-dd-HH-MM-SS_X.avi".
Main features:
*find an astrometric solution for the acquisition system, namely parameters that enable to go from pixel (x,y) to horizontal coordinates (Az,el).
*perform a photometric calibration based on brightest stars, with minimun user intervention.
*find trajectory and light curve of meteor based on previous astro- and photometric calibrations, the latter through a novel methodology for meteor brightness estimate.

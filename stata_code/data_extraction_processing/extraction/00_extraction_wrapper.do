/*This extracts data for Karl's Scallop project.  There is a collection of do files that does the actual work, this is essentially a wrapper and table of contents. 
 */

#delimit ;

 
global oracle_cxn " $myNEFSC_USERS_conn";
global my_codedir "${my_projdir}/stata_code/data_extraction_processing/extraction";
global my_workdir  "${my_projdir}/data_folder/main";
global results  "${my_projdir}/results";


global network_temp_dir "V:\KA_Scallop\data" ;
global spacepanels_data "C:/Users/Min-Yang.Lee/Documents/spacepanels/data_folder/main/veslog_species_huge_2023_11_29";
global income_mobility "C:/Users/Min-Yang.Lee/Documents/incomemobility/data_folder/internal/nameclean";




 
pause off;

log using "${results}/KA_extraction.smcl", replace;
timer on 1;

local date: display %td_CCYY_NN_DD date(c(current_date), "DMY");
global today_date_string = subinstr(trim("`date'"), " " , "_", .);

global firstyr 2004;
global secondyr =$firstyr+1;

global lastyr 2022;



do "${my_codedir}/construct_owners.do";

do "${my_codedir}/scallop_mri.do";
do "${my_codedir}/permit_characteristics_extractions.do";
do "${my_codedir}/declaration_codes.do";



/* build the codebooks */
do "${my_codedir}/fishery_key_file.do";
do "${my_codedir}/port_key_file.do";
do "${my_codedir}/dealer_key_file.do";








/* these don't run 


do "${my_codedir}/mort_elig_criteria_extractions.do";
do "${my_codedir}/cr_boats.do";

*/




# delimit ;


do "${my_codedir}/cams_data_dump.do";



/* Get VTR data at the gearid level */


/* need to pull in SFCLAM 

do "${my_codedir}/processed_data_subset.do";
do "${my_codedir}/final_geoid_clean.do";*/
do "${my_codedir}/copyover_operator_data.do";













/* Data straight from GARFO. */

do "${my_codedir}/das_allocations.do";
do "${my_codedir}/das_allocations_usedR.do";


log close;



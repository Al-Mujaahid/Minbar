
const base_url = 'http://173.212.202.67/minbar/api/';

// Auth Endpoint
const loginEndpoint = '${base_url}Login_post';
const registerEndpoint = '${base_url}Register_post';
const requestPasswordChangeEndpoint = '${base_url}RequestResetPin';
const userdataEndpoint = '${base_url}Volunteer/detail/';
const changePasswordEndpoint = '${base_url}UpdatePassword/update_password';

//Add Mosque
const addMosqueEndpoint = '${base_url}Volunteer/add_mosque';
const updateMosqueEndpoint = '${base_url}Volunteer/update_mosque';
const getListOfStateEndpoint = '${base_url}Location/getStates';
const getListOfLCDAEndpoint = '${base_url}Location/getStateLocals/';
import 'dart:developer';

import 'package:googleapis_auth/auth_io.dart';

class GetServerKey {
  //First lets add the endpoint url
  static String firebaseMessagingScope =
      "https://www.googleapis.com/auth/firebase.messaging";

  Future<String> getAccessToken() async {
    final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson({
          "type": "service_account",
          "project_id": "hikespot-taxi-app",
          "private_key_id": "82fa68bbcc900fe09c64e1cd9fd80cb440d2fc63",
          "private_key":
              "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCrFrHw1CJJlFu7\nJX/TRVBv8Ng426YDQGg/J9ZKXbQtR7x7DefHRlGmAWboyMkpCe1nkq7+Lo5IMP/0\n23bdmhaE4pqxVKLo7yIm3ASCtps12mEZw7pLE63D5bFBHJo1a+7ozKRNbQ7hNyzg\nor1gI/NOk1rHpxk6lr0J8mwOrCr9IwvHVAtKEOoORm3DaZ4jdx9KU2W5+HfuAmEw\njXgVq4wAcotDJji8usxBF6dYIXxM87clfdq7qDjLnmnU2+WaRR94dejy8/pShjhV\npSfpxknQtp7UTFuxanuFC4PRkU36ZIAureoM3Ez4kjjdgN9aqb/QEKU0jqhHjKnQ\nTkYRq2T7AgMBAAECggEAHudkkPngj6Xqw+1MH59/nhjFFdAnNqMlsXLCtIAkkaFJ\nnHiwi0Bac0ABlL7gBzex2GmYjnVeYg/nzBTwbartsmc0Rh/hpW28n4RSlEHj22Bs\n9bhzKCiP1Ljiwb4m5MtwRkDg1NOEQo4y3wjGaF1WD7VySmoWloyv7OILPsM+qKam\nPI+5X+yqPzrwbFWZJRROKN69Yu3Y9fe9GrPpQom1yxj2SKtRkzXIvsWCJm+nhWbP\nvxP+QgYU1DO0O55TrLCvbCfxqPIdoI3eeuAtOTNhGa5Zs4r5R+KEYX6mB0kwj49p\n61mHqdln+6rh73CVrULlbhosaR4i5Wa2W56o330lIQKBgQDc40sdc1p+uPInPy68\nZjT/rag79FwAVIJbpQ30YMpRp05+Z0VntbAqixhHKdtni6dJpDHZAGjwwq/z7Cqd\nExTY3YV9Rso9dsByQ12zzU+xFaTLUkisO/T2NOtVfSPVQVEnvbPqIS0vyVnZQJAW\nt59OeFaObh5kj/pRRfhd4/jtkwKBgQDGSOVg5I1Ix0TMm+M5ZLx+6SjM6475s4WT\n6op1KieAvh1RB5zzfJxB2w7L1SN7R39wRoZozBB3QiPzvUzT2/7AYW37HYcPXbVF\n3FTb7QwxmTdhi4PRpsThOFvghgJ5GJLF2UP6vnbOL4wojFIz/PJAMD9rWGW2Ccyn\nHpOSUq0L+QKBgDAp120ag/bxuMtZ+YTW/GNrqC06gP0JcEsvWDWbDUJ0qqbhOb79\nXOZJ4gdSVybiyp1CEiRw9HDa4qbbLgeF65vF4Z+JWfvA8wF3Mu1LrT69q2syC+qS\nQD2XGGFRogiT73As6xf4F/Q9gTvf2gs6CqB/mNABrtrakgg6q4c9eD/FAoGAAZRP\nD2iCn5PGvoJ3WtusjK46vvcZWm/NnpH9rFU7n1DkVuLioyXY8MVX5tO5xp+ZKkHF\njEwjzW9fbe+SDxXvf4THJXrkuoCakwXgPygyMqrvv/0mfaMAanLSeIVYu7IwaRcD\n7ZlaxOWoDiKf/P4Ex/IabzZzCPInCSW7My0pZ7ECgYBaz/Ei9xr6FsxaxYJQDP54\nCojIkiN+BaiTCb/mSFvZoxRr4ev3DG10ynJcAQYnuim/6w04dQ5d4aK03JRezou9\nUzf9q/CEqQyyHGvUeETEusNwwc4mEG81Q3Yz9K9BuFpXALkHQAI2JPTwhJ8ikBgp\nvgA1Gi/IKhDgAYZUEcoTaQ==\n-----END PRIVATE KEY-----\n",
          "client_email":
              "firebase-adminsdk-ur50j@hikespot-taxi-app.iam.gserviceaccount.com",
          "client_id": "110812942141180849970",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url":
              "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url":
              "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-ur50j%40hikespot-taxi-app.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }),
        [firebaseMessagingScope]);

    final accessToken = client.credentials.accessToken.data;
    log("access token $accessToken");
    return accessToken;
  }
}

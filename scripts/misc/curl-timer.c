#include <stdio.h>
#include <curl/curl.h>

static size_t WriteCallback(void *ptr, size_t size, size_t nmemb, void *data) {
  /* we are not interested in the downloaded bytes itself,
   *      so we only return the size we would have saved ... */
  (void)ptr;  /* unused */
  (void)data; /* unused */
  return (size_t)(size * nmemb);
}

int main(int argc, const char *argv[]) {
  CURL *curl;
  CURLcode res;
  FILE *headerfile;
  FILE *bodyfile;
  headerfile = fopen("header.txt", "w");
  bodyfile = fopen("/dev/null", "w");
  curl = curl_easy_init();
  if (curl) {
    res = curl_easy_setopt(curl, CURLOPT_URL, argv[1]);
    /* curl_easy_setopt(curl, CURLOPT_HEADER, "http://www.baidu.com"); */
    curl_easy_setopt(curl, CURLOPT_WRITEHEADER, headerfile);
    /* curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, WriteCallback); */
    curl_easy_setopt(curl, CURLOPT_WRITEDATA, bodyfile);
    res = curl_easy_perform(curl);
  }

  if (CURLE_OK == res) {
    double dsize;
    res = curl_easy_getinfo(curl, CURLINFO_SIZE_DOWNLOAD, &dsize);
    if ((CURLE_OK == res) && (dsize > 0))
      printf("Data downloaded size: %0.3f kbyte/sec\n", dsize / 1024);

    int code;
    res = curl_easy_getinfo(curl, CURLINFO_RESPONSE_CODE, &code);
    if ((CURLE_OK == res) && (code > 0))
      printf("The response code is: %d \n", code);

    double lookuptime;
    res = curl_easy_getinfo(curl, CURLINFO_NAMELOOKUP_TIME, &lookuptime);
    if (CURLE_OK == res)
      printf("The DNS lookup time is: %0.3f sec.\n", lookuptime);

    double connect_time;
    res = curl_easy_getinfo(curl, CURLINFO_CONNECT_TIME, &connect_time);
    if (CURLE_OK == res)
      printf("The connect time is: %0.3f sec.\n", connect_time);

    double totaltime;
    res = curl_easy_getinfo(curl, CURLINFO_TOTAL_TIME, &totaltime);
    if ((CURLE_OK == res) && (totaltime > 0))
      printf("Total download time: %0.3f sec.\n", totaltime);

    double speed;
    res = curl_easy_getinfo(curl, CURLINFO_SPEED_DOWNLOAD, &speed);
    if ((CURLE_OK == res) && (speed > 0))
      printf("Download speed: %0.3f kbyte/sec.\n", speed / 1024);

    char *ip;
    res = curl_easy_getinfo(curl, CURLINFO_PRIMARY_IP, &ip);
    if (CURLE_OK == res)
      printf("The IP address is: %s\n", ip);

    char * header;
    res = curl_easy_getinfo(curl,CURLINFO_CONTENT_TYPE, &header);
    if(CURLE_OK == res)
      printf("The content type is: %s\n", header );
  }

  /* always cleanup */
  curl_easy_cleanup(curl);
  fclose(headerfile);
  fclose(bodyfile);

  return 0;
}

/* =============================================================== *
 * vim modeline                                                    *
 * vim: se fdm=expr foldexpr=getline(v\:lnum)=~'^\\S.*{'?'>1'\:1:  *
 * =============================================================== */

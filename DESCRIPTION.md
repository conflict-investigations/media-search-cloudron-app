### About

Check whether a (social) media post already exists in several databases (e.g.
Belllingcat's, Cen4InfoRes).

**Available routes**

- `/`: Web UI
- `/api/v1/export` - `GET` - Export all URLs as JSON
- `/api/v1/query` - `GET`/`POST` - Check if URL is in a database  
  **params**: `url`: The url to search (either as request args or as JSON body)  
  **response:**
  ```json
  {
    "dataset": [
      {
        "desc": "ENTRY: UW[...]", 
        "id": "UW13293", 
        "source": "CEN4INFORES"
      }
    ], 
    "message": "Success! Url found in database", 
    "success": true
  }
  ```
  If the entry as not found, `success` is `false`.

### Obtaining data

This `cloudron` application will download/refresh the data on every app start.

The `Belllingcat` database is from their
[Civilian Harm in Ukraine](https://ukraine.bellingcat.com/) project.
There's an "Export to JSON" button.

The `Cen4InfoRes` database is from the Center for Information Resilience's
[Eyes on Russia map](https://maphub.net/Cen4infoRes/russian-ukraine-monitor).

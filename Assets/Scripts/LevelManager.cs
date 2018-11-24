using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class LevelManager : MonoBehaviour {

    public static LevelManager Instance { get; set; }
    private float opacity = 0.0f;
    public SpriteRenderer background;
    public Image image;

    public List<Sprite> paints;
    public bool full = false;
    [HideInInspector]
    public int currentPaint = 0;

    [HideInInspector]
    public List<string> palette;

    private void Awake()
    {
        if (Instance == null)
        {
            Instance = this;
            DontDestroyOnLoad(gameObject);
        }
        palette = new List<string>() {"red", "green", "blue"};
    }

    // Update is called once per frame
    void Update () {
        if (Input.GetKeyDown(KeyCode.Alpha0))
        {
            SwitchImage(1);
        }
    }

    public void LoadLevel(string levelName)
    {
        SceneManager.LoadScene(levelName);
    }

    public void SongCollected()
    {
        if (opacity<= 1)
        {
            opacity += 0.25f;
            background.color = new Color(1,1,1,opacity);
        }
    }


    public void SwitchImage(int index)
    {
        currentPaint = index;
        image.sprite = paints[currentPaint];
        full = true;
    }

    public void EmptyPaint()
    {
        currentPaint = 0;
        SwitchImage(currentPaint);
        full = false;
    }
}

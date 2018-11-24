using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class LevelManager : MonoBehaviour {

    public static LevelManager Instance { get; set; }
    public float greyscale = 1.0f;
    public SpriteRenderer background;
    public Image image;

    public List<Sprite> paints;
    public bool full = false;
    [HideInInspector]
    public int currentPaint = 0;
    private int score = 0;
    public Text textScore;

    private void Awake()
    {
        if (Instance == null)
        {
            Instance = this;
        }
    }


    public void LoadLevel(string levelName)
    {
        SceneManager.LoadScene(levelName);
    }

    public void SongCollected()
    {
        if (greyscale > 0)
        {
            score++;
            textScore.text = score + "/4";
            if (score>=4)
            {
               LoadLevel("Victory");
            }
            greyscale -= 0.25f;
            background.color = new Color(1,1,1,1-greyscale);
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

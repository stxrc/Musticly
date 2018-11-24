using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BoxManager : MonoBehaviour {

    private Animator anim;
    public AudioSource audio;
    public int boxColor;
    private void Start()
    {
        anim = GetComponent<Animator>();
    }
    private void OnTriggerEnter2D(Collider2D collision)
    {
        if (collision.gameObject.tag == "Player")
        {
            if (LevelManager.Instance.currentPaint ==boxColor)
            {
                LevelManager.Instance.EmptyPaint();
                anim.SetBool("waken", true);
                audio.Play();
                LevelManager.Instance.SongCollected();
            }

        }
    }
}

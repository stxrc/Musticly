using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PaintItem : MonoBehaviour {

    public int color;

    public void OnTriggerEnter2D(Collider2D collision)
    {
        if (!LevelManager.Instance.full)
        {
            LevelManager.Instance.SwitchImage(color);
            Destroy(gameObject);
        }
    }
}

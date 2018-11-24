using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EventListener : MonoBehaviour {

    public List<Sprite> sprites;
    private int currentSprite = 0;
    private SpriteRenderer renderer;

    private void Start()
    {
        renderer = GetComponent<SpriteRenderer>();
       
    }

    public void Update()
    {
        renderer.sprite = sprites[currentSprite];
    }

    private void OnTriggerEnter2D(Collider2D collision)
    {
        currentSprite = (currentSprite + 1) % sprites.Count;
    }
}

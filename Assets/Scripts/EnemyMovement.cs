using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyMovement : MonoBehaviour {
	float speed;
	public SpriteRenderer mySpriteRenderer;
	public LayerMask groundLayer;
	int dir;
	Rigidbody2D body;
	Transform obj_transform;
	// Use this for initialization
	void Start () {
		speed = 2; //change negative dir
		obj_transform = this.transform;
		dir = -1;
		body = this.GetComponent<Rigidbody2D> ();
		mySpriteRenderer = GetComponent<SpriteRenderer>();
	}

	// Update is called once per frame
	void Update () {

			GetComponent <Rigidbody2D> ().velocity = new Vector2 (speed, GetComponent<Rigidbody2D> ().velocity.y);

	}
    private void OnCollisionEnter2D(Collision2D other)
    {
        if (other.gameObject.tag == "Wall")
        {
            Vector2 myVelocity = body.velocity;
            if (dir == -1)
            {
                speed = -2;
                dir = 1;
                mySpriteRenderer.flipX = true;
            }
            else if (dir == 1)
            {
                speed = 2;
                dir = -1;
                mySpriteRenderer.flipX = false;

            }
            myVelocity.x = obj_transform.right.x * speed;
            body.velocity = myVelocity;
        }
    }
}
